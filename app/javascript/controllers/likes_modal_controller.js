import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="likes-modal"
export default class extends Controller {
  connect() {
  }
  
  close(e) {
    e.preventDefault();
    const modal = document.getElementById("likes")
    modal.innerHTML = ""
  }
}
