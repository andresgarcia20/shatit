const destDiv = document.getElementById('destinations')
const destEditDiv = document.getElementById('destinations_edit')
const destBtn = document.getElementById('btn_destinations')

// if (window.location.href.includes("/trips") && window.location.href.includes("edit")) {
//   destDiv.classList.add("d-none")
// } else {
//   destEditDiv.classList.add("d-none")
// }
let count = 1
destBtn.onclick = () => {
  if (count < 9) {
    addNewInput()
    count++
  }
}

function addNewInput() {
  const br = document.createElement('br')
  const input = document.createElement('input')
  input.setAttribute('multiple', 'multiple')
  input.setAttribute('type', 'text')
  input.setAttribute('value', '')
  input.setAttribute('name', 'trip[destinations][]')
  input.setAttribute('id', 'trip_destinations')
  destDiv.appendChild(br)
  destDiv.appendChild(input)
}