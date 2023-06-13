import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    console.log(this.markersValue)
    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v12"
    })
    this.#addMarkersToMap()
    this.#fitMapToMarkers()
  }
  
  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach ((marker) => {
      bounds.extend([ marker.lat, marker.lng ])
    })
    this.map.fitBounds(bounds, { padding: 50, duration: 10 })
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)
      new mapboxgl.Marker()
        .setLngLat([marker.lat, marker.lng])
        .setPopup(popup)
        .addTo(this.map);
    })
  }
}
