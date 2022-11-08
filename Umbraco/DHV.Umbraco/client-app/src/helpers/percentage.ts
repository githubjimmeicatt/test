const percentageOptions: Intl.NumberFormatOptions = {
  style: 'percent',
  notation: 'standard',
  minimumFractionDigits: 1,
}

const percentageFormat = new Intl.NumberFormat('nl-NL', percentageOptions)

export const parsePercentageToNumber = (s: string) => (s ? Number.parseFloat(s.replace(',', '.').replace('%', '')) : 0)
export const parseAndFormatPercentage = (s: string) => percentageFormat
  .format(parsePercentageToNumber(s) / 100)
