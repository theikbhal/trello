import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  static targets = ["cards"]

  connect() {
    this.sortable = Sortable.create(this.cardsTarget, {
      group: "cards",
      animation: 150,
      ghostClass: "opacity-50",
      onEnd: this.onEnd.bind(this)
    })
  }

  disconnect() {
    if (this.sortable) this.sortable.destroy()
  }

  onEnd(event) {
    const cardId = event.item.dataset.cardId
    const newListId = event.to.dataset.listId
    const newPosition = event.newIndex + 1

    if (!cardId) return

    const boardId = this.element.closest("[data-board-id]")?.dataset.boardId

    fetch(`/boards/${boardId}/cards/${cardId}/move`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
      },
      body: JSON.stringify({
        list_id: newListId,
        position: newPosition
      })
    })
  }
}