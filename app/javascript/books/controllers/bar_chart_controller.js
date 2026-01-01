import { Controller } from "@hotwired/stimulus"
import {
  Chart,
  BarController,
  BarElement,
  CategoryScale,
  LinearScale,
  Tooltip
} from "chart.js"

Chart.register(
  BarController,
  BarElement,
  CategoryScale,
  LinearScale,
  Tooltip
)

Chart.defaults.font.family = "Handlee"
Chart.defaults.font.size = 16
Chart.defaults.font.lineHeight = 1.5

export default class BarChartController extends Controller {
  static targets = ["canvas"]
  #_sourceTable

  get #sourceTable() {
    return this.#_sourceTable ??= this.canvasTarget.querySelector('table')
  }

  connect() {
    this.chart = new Chart(
      this.canvasTarget,
      this.#dataFromSourceTable()
    )
  }

  #dataFromSourceTable() {
    const headers = Array.from(this.#sourceTable.tHead.rows[0].cells).map(cell => cell.innerText)
    const labels = []
    const data = []
    Array.from(this.#sourceTable.tBodies[0].rows).forEach(row => {
      labels.push(row.cells[0].innerText)
      data.push(row.cells[1].innerText)
    })

    return {
      type: 'bar',
      data: {
        labels,
        datasets: [{
          data,
          borderColor: "#000000",
          borderWidth: 2,
          backgroundColor: this.#fillPattern()
        }]
      },
      options: {
        animation: false,
        maintainAspectRatio: false,
        scales: {
          x: {
            title: headers[0],
            grid: {
              display: false
            },
            border: {
              color: "#000000"
            }
          },
          y: {
            title: headers[1],
            ticks: {
              stepSize: 1
            },
            grid: {
              display: false
            },
            border: {
              color: "#000000"
            }
          }
        }
      }
    }
  }

  #fillPattern() {
    const patternCanvas = new OffscreenCanvas(64, 64)
    const context = patternCanvas.getContext('2d')

    context.strokeStyle = "rgb(0, 0, 0, 0.5)"
    context.fillStyle = "rgb(255, 255, 255, 0.5"
    context.fillRect(0, 0, 64, 64)
    context.lineWidth = 1
    context.lineCap = "square"
    const path = new Path2D()
    path.moveTo(0, 16)
    path.lineTo(64, 0)

    for (let i = -64; i <= 64; i += 16) {
      context.resetTransform()
      context.translate(0, i)
      context.stroke(path)
    }

    const chartCanvas = this.canvasTarget
    const chartContext = chartCanvas.getContext('2d')
    return chartContext.createPattern(patternCanvas, "repeat")
  }
}
