import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="post-comments"
export default class extends Controller {
  connect() {

  }
  
  close(e) {
    e.preventDefault();
    const modal = document.getElementById("postComments")
    modal.innerHTML = ""

  }
}
