import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["upload"]

  reset() {
    this.element.reset()
    
    if (this.hasUploadTarget) {
      this.uploadTarget.innerHTML = "No file selected."
    }
  }
}