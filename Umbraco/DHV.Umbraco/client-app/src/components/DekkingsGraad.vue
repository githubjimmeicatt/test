<template>
  <section class="container">
    <h1>{{title}}</h1>
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
import { shortDate } from '@/helpers/formatDate'

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

const props = defineProps<{
  title: string;
  data: {
    date: string;
    actueel: string;
    beleid: string;
    minimaalVereist: string;
    vereistFTK: string;
  }[]
}>()

const parsePercentage = (s: string) => (s ? Number.parseFloat(s.replace(',', '.').replace('%', '')) : 0)

const labels = computed(() => props.data.map(({ date }) => shortDate(date) || ''))

const actueelSet = computed<LineDataSet>(() => {
  const data = props.data.map(({ actueel }) => parsePercentage(actueel))
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
  const data = props.data.map(({ beleid }) => parsePercentage(beleid))
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
  const data = props.data.map(({ minimaalVereist }) => parsePercentage(minimaalVereist))
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
  const data = props.data.map(({ vereistFTK }) => parsePercentage(vereistFTK))
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
.chart-wrapper {
  width: min(100%, 40rem);
  // margin-inline: auto;
}
</style>
