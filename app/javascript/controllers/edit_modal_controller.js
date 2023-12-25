import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="edit-modal"
export default class extends Controller {
  connect() {
    const modal = document.getElementById("editModal")
    modal.addEventListener('turbo:submit-end', (event) => {
      console.log(event);
      modal.innerHTML = ""
    });
  }
  
  close(e) {
    e.preventDefault();
    const modal = document.getElementById("editModal")
    modal.innerHTML = ""

  }
}
