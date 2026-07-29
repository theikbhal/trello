import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  static targets = ["list"]

  connect() {
    this.sortable = Sortable.create(this.element, {
      animation: 150,
      ghostClass: "opacity-50",
      handle: ".list-handle",
      onEnd: this.onEnd.bind(this)
    })
  }

  disconnect() {
    if (this.sortable) this.sortable.destroy()
  }

  onEnd(event) {
    const listId = event.item.dataset.listId
    const newPosition = event.newIndex + 1
    if (!listId) return

    const boardId = this.element.dataset.boardId

    fetch(`/boards/${boardId}/lists/${listId}/move`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
      },
      body: JSON.stringify({ position: newPosition })
    })
  }
}