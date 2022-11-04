<template>
  <section class="container">
    <h1>{{title}}</h1>
    <div class="table-wrapper">
      <table>
        <thead>
          <tr><th>SPHDHV</th><th>Actuele dekkingsgraad</th><th>Beleidsdekkingsgraad</th></tr>
        </thead>
        <tbody>
          <tr v-for="(row, i) in descendingData" :key="i">
            <td>{{shortDate(row.date)}}</td>
            <td>{{percentageFormat.format(parseNumber(row.actueel) / 100)}}</td>
            <td>{{percentageFormat.format(parseNumber(row.beleid) / 100)}}</td>
          </tr>
        </tbody>
      </table>
    </div>
    <LineChart class="chart-wrapper" :chart-data="chartData" :chart-options="chartOptions" />
  </section>
</template>

<script setup lang="ts">
import { Line as LineChart } from 'vue-chartjs'
import type { TChartData, TChartOptions } from 'vue-chartjs/dist/types'
import {
  Title,
  Tooltip,
  Legend,
  LineElement,
  LinearScale,
  PointElement,
  CategoryScale,
  Chart as ChartJS,
  type ChartDataset,
} from 'chart.js'
import { computed } from 'vue'
import { shortDate, parseDate } from '@/helpers/formatDate'

type LineChartData = TChartData<'line'>
type LineChartOptions = TChartOptions<'line'>
type LineDataSet = ChartDataset<'line'>

ChartJS.register(
  Title,
  Tooltip,
  Legend,
  LineElement,
  LinearScale,
  PointElement,
  CategoryScale,
)

type Data = {
  date: string;
  actueel: string;
  beleid: string;
  minimaalVereist: string;
  vereistFTK: string;
}

const props = defineProps<{
  title: string;
  data: Data[]
}>()

const percentageOptions: Intl.NumberFormatOptions = {
  style: 'percent',
  notation: 'standard',
  minimumFractionDigits: 1,
}
const percentageFormat = new Intl.NumberFormat('nl-NL', percentageOptions)
const parseNumber = (s: string) => (s ? Number.parseFloat(s.replace(',', '.').replace('%', '')) : 0)

const getTime = (d: string) => parseDate(d)?.getTime() || 0
const byDateAscending = (a: Data, b: Data) => getTime(a.date) - getTime(b.date)
const byDateDescending = (a: Data, b: Data) => getTime(b.date) - getTime(a.date)

const labels = computed(() => props.data.map(({ date }) => shortDate(date) || ''))

const ascendingData = computed(() => [...props.data].sort(byDateAscending))
const descendingData = computed(() => [...props.data].sort(byDateDescending))

const actueelSet = computed<LineDataSet>(() => {
  const data = ascendingData.value.map(({ actueel }) => parseNumber(actueel))
  return {
    label: 'Actuele dekkingsgraad',
    data,
    borderColor: '#0086a8',
    pointBackgroundColor: '#0086a8',
    pointRadius: 5,
    pointHoverRadius: 7,
  }
})

const beleidSet = computed<LineDataSet>(() => {
  const data = ascendingData.value.map(({ beleid }) => parseNumber(beleid))
  return {
    label: 'Beleidsdekkingsgraad',
    data,
    borderColor: '#cc0000',
    pointStyle: 'rectRot',
    pointBackgroundColor: '#cc0000',
    pointRadius: 5,
    pointHoverRadius: 7,
  }
})

const minimaalSet = computed<LineDataSet>(() => {
  const data = ascendingData.value.map(({ minimaalVereist }) => parseNumber(minimaalVereist))
  return {
    label: 'Minimaal vereiste dekkingsgraad',
    data,
    borderColor: '#cccccc',
    pointStyle: 'rect',
    pointBackgroundColor: '#cccccc',
    pointRadius: 5,
    pointHoverRadius: 7,
  }
})

const ftkSet = computed<LineDataSet>(() => {
  const data = props.data.map(({ vereistFTK }) => parseNumber(vereistFTK))
  return {
    label: 'Vereiste FTK dekkingsgraad',
    data,
    borderColor: '#9933ff',
    pointStyle: 'triangle',
    pointBackgroundColor: '#9933ff',
    pointRadius: 5,
    pointHoverRadius: 7,
  }
})

const chartOptions: LineChartOptions = {
  responsive: true,
  maintainAspectRatio: true,
  aspectRatio: 1.5,
  plugins: {
    legend: {
      position: 'bottom',
      labels: {
        boxWidth: 15,
        textAlign: 'left',
        usePointStyle: true,
      },

    },
  },
}

const chartData = computed<LineChartData>(() => ({
  labels: labels.value,
  datasets: [actueelSet.value, beleidSet.value, minimaalSet.value, ftkSet.value],
}))
</script>

<style lang="scss" scoped>
.chart-wrapper, .table-wrapper {
  width: min(100%, 40rem);
}

.table-wrapper {
  margin-block-end: 4rem;
  overflow-x: auto;
}

table {
  // min-width: 100%;
  border-collapse: collapse;
}

th, td {
  text-align: left;
  white-space: nowrap;
  padding: 0.25rem .5rem;
}

th {
  background-color: var(--color-accent-1);
  border: 1px solid var(--color-base);
  color: white;
}

td {
  border: 1px solid #d4d4d4;
}

tbody tr:nth-child(even) td {
    background-color: #f2f9fb;
}
</style>
