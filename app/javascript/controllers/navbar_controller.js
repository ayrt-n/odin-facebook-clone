import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["burger", "menu"]

  toggle() {
    const burger = this.burgerTarget
    const menu = this.menuTarget

    burger.classList.toggle('is-active')
    menu.classList.toggle('is-active')
  }
}