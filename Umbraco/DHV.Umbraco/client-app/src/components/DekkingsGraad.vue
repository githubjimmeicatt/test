<template>
  <section class="container">
    <h1>{{title}}</h1>
    <RichText :body="intro" />
    <template v-for="(item, idx) in visualItems" :key="idx">
      <div class="table-wrapper" v-if="item === 'table'">
        <table>
          <thead>
            <tr>
              <th>SPHDHV</th>
              <th>Actuele dekkings&shy;graad</th>
              <th>Beleids&shy;dekkings&shy;graad</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="({ date, actueel, beleid }, i) in tableData" :key="i">
              <td class="nowrap"><time v-if="date" :datetime="date.iso">{{date.display}}</time></td>
              <td class="nowrap">{{actueel}}</td>
              <td class="nowrap">{{beleid}}</td>
            </tr>
          </tbody>
        </table>
      </div>
      <LineChart
        v-if="item === 'graph'"
        class="chart-wrapper"
        :chart-data="chartData"
        :chart-options="chartOptions"
      />
    </template>

  </section>
</template>

<script lang="ts">
import {
  Title,
  Tooltip,
  Legend,
  LineElement,
  LinearScale,
  PointElement,
  CategoryScale,
  Chart as ChartJS,

} from 'chart.js'
import { parseAndFormatPercentage, parsePercentageToNumber } from '@/helpers/percentage'

ChartJS.register(
  Title,
  Tooltip,
  Legend,
  LineElement,
  LinearScale,
  PointElement,
  CategoryScale,
)
</script>

<script setup lang="ts">
import { Line as LineChart } from 'vue-chartjs'
import type { TChartData, TChartOptions } from 'vue-chartjs/dist/types'
import type { ChartDataset } from 'chart.js'
import { computed } from 'vue'
import { shortDate, isoDate } from '@/helpers/formatDate'
import { useMediaQuery } from '@vueuse/core'

import parseDate from '@/icatt-heartcore/api/parse-date'
import RichText from './RichText.vue'

type LineChartData = TChartData<'line'>
type LineChartOptions = TChartOptions<'line'>
type LineDataSet = ChartDataset<'line'>

type Data = {
  date: string;
  actueel: string;
  beleid: string;
  minimaalVereist: string;
  vereistFTK: string;
}

const props = defineProps<{
  title: string;
  data: {
    data: Data[];
  };
  order: string;
  intro: string;
}>()

type VisualItem = 'table' | 'graph'

const visualItems = computed<VisualItem[]>(() => {
  switch (props.order) {
    case 'Eerst grafiek, dan tabel':
      return ['graph', 'table']
    case 'Alleen tabel':
      return ['table']
    case 'Alleen grafiek':
      return ['graph']
    case 'Eerst tabel, dan grafiek':
    default:
      return ['table', 'graph']
  }
})

const getTime = (d: string) => parseDate(d)?.getTime() || 0
const byDateAscending = (a: Data, b: Data) => getTime(a.date) - getTime(b.date)
const byDateDescending = (a: Data, b: Data) => getTime(b.date) - getTime(a.date)

const labels = computed(() => props.data.data.map(({ date }) => shortDate(date) || ''))

const ascendingData = computed(() => [...props.data.data].sort(byDateAscending))
const descendingData = computed(() => [...props.data.data].sort(byDateDescending))

const actueelSet = computed<LineDataSet>(() => {
  const data = ascendingData.value.map(({ actueel }) => parsePercentageToNumber(actueel))
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
  const data = ascendingData.value.map(({ beleid }) => parsePercentageToNumber(beleid))
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
  const data = ascendingData.value.map(({ minimaalVereist }) => parsePercentageToNumber(minimaalVereist))
  return {
    label: 'Minimaal vereiste dekkingsgraad',
    data,
    borderColor: '#717171',
    pointStyle: 'rect',
    pointBackgroundColor: '#717171',
    pointRadius: 5,
    pointHoverRadius: 7,
  }
})

const ftkSet = computed<LineDataSet>(() => {
  const data = ascendingData.value.map(({ vereistFTK }) => parsePercentageToNumber(vereistFTK))
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

const isSmallScreen = useMediaQuery('(max-width: 30rem)')

const chartOptions = computed<LineChartOptions>(() => ({
  responsive: true,
  maintainAspectRatio: true,
  aspectRatio: isSmallScreen.value ? 0.875 : 1.5,
  layout: {
    padding: {
      bottom: 20,
    },
  },
  plugins: {
    legend: {
      position: 'bottom',
      labels: {
        boxWidth: 15,
        textAlign: 'left',
        usePointStyle: true,
        padding: 30,
      },
    },
  },
}))

const chartData = computed<LineChartData>(() => ({
  labels: labels.value,
  datasets: [actueelSet.value, beleidSet.value, minimaalSet.value, ftkSet.value],
}))

const tableData = computed(() => descendingData.value.map(({ date, actueel, beleid }) => {
  const dateTime = parseDate(date)
  return {
    date: dateTime && {
      iso: isoDate(dateTime),
      display: shortDate(dateTime),
    },
    actueel: parseAndFormatPercentage(actueel),
    beleid: parseAndFormatPercentage(beleid),
  }
}))
</script>

<style lang="scss" scoped>
  .chart-wrapper, .table-wrapper {
    &:not(:last-child) {
      margin-block-end: 1rem;
    }
  }
</style>
