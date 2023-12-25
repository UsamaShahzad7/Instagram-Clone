import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="comment-modals"
export default class extends Controller {
  connect() {
    const modal = document.getElementById("comment")
    modal.addEventListener('turbo:submit-end', (event) => {
      console.log(event);
      modal.innerHTML = ""
    });
  }
  
  close(e) {
    e.preventDefault();
    const modal = document.getElementById("comment")
    modal.innerHTML = ""

  }
}
