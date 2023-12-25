import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modals"
export default class extends Controller {
  connect() {
    const modal = document.getElementById("modal")
    modal.addEventListener('turbo:submit-end', (event) => {
      console.log(event);
      modal.innerHTML = ""
    });
  }
  
  close(e) {
    e.preventDefault();
    const modal = document.getElementById("modal")
    modal.innerHTML = ""
  }
}
