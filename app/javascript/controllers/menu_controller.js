import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["items"];

  toggle() {
    this.itemsTarget.classList.toggle("hidden");
    this.itemsTarget.classList.toggle("flex");
  }
}
