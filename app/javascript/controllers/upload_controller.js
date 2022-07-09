import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "output"]

  display() {
    const filename = this.inputTarget.value.split("\\").pop()

    if (filename) {
      this.outputTarget.innerHTML = filename
    } else {
      this.outputTarget.innerHTML = "No file selected."
    }
  }
}