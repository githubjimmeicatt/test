<template>
  <slot
    name="header"
    :menu="menu"
  >
    <the-header />
  </slot>
  <main>
    <slot
      name="main"
      :content="content"
    />
  </main>
  <slot
    name="footer"
    :menu="menu"
  >
    <the-footer
      :menu="menu"
    />
  </slot>
</template>

<script>
import { inject } from 'vue'
import TheHeader from '../components/TheHeader.vue'
import TheFooter from '../components/TheFooter.vue'

export default {
  components: { TheHeader, TheFooter },
  props: {
    theme: {
      type: String,
      default: '',
    },
  },
  setup() {
    const menu = inject('menu')
    const content = inject('content')
    return {
      menu,
      content,
    }
  },
}
</script>

<style lang="scss">
@import "../assets/scss/_mixins.scss";
@import "nprogress/nprogress.css";

#nprogress {
  .bar {
    background: var(--color-accent-1) !important;
    height:3px !important;
  }
  .peg {
    box-shadow: 0 0 10px var(--color-accent-1), 0 0 5px var(--color-accent-1);
  }
  .spinner  .spinner-icon {
    border-top-color: var(--color-accent-1);
    border-left-color: #FFBB00;
    width:30px !important;
    height:30px !important;

  }
}

@include fonts;

p.richtext, .richtext p {
  line-height: 1.5rem;
}

html, body {
  margin: 0;
  padding: 0;
}

.bold {
  font-weight: bold;
}

body {
  max-width: 100vw;
  font-family: 'Open Sans', sans-serif;
}

textarea {
  font: inherit;
}

#app {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

main {
  display: flex;
  flex-direction: column;
  flex: 1;
}

html {
  box-sizing: border-box;

}

*, *:before, *:after {
  box-sizing: inherit;
}

:root {
  // base variables

  --space-smallest: 0.25rem;
  --space-smaller: 0.5rem;
  --space-small: 1rem;
  --space-medium: 2.5rem;
  --space-large: 4rem;
  --space-larger: 8rem;
  --space-largest: 11.5rem;

  --dynamic-spacing-medium: max(1rem, calc(50vw - var(--card-width) * 1.5 - var(--card-gap)));
  --dynamic-spacing-large: max(1rem, calc(50vw - var(--card-width-large) - 1.75rem));
  --gap-medium: #{$gap-medium};

  --card-gap: #{$gap-medium};
  --card-border: #{$card-border};
  --card-width: #{$card-width};
  --card-width-small: #{$card-width-small};
  --card-width-large: #{$card-width-large};

  --card-two-width: #{$card-two-width};

  --card-three-width: #{$card-three-width};

  --card-four-width: #{$card-four-width};

  --max-text-width: min(100%, 50rem);

.arrow-before::before {
    @include arrow-inline();
    margin-right: 0.5rem;
}

.arrow-after::after {
    @include arrow-inline();
    margin-left: 0.5rem;
}
  // themes
  --color-background-1: rgb(229, 243, 246);
  --color-background-2: rgb(229, 243, 246);

  // sph
  --color-sph-base: rgb(0, 86, 125);
  --color-sph-accent-1: rgb(0, 134, 168);
  --color-sph-accent-2: rgb(229, 243, 246);
  --color-sph-accent-1-dark: rgb(0, 134, 168);
  --color-sph-accent-2-dark: rgb(229, 243, 246);
  --color-sph-table: rgb(242, 249, 251);

  --color-error: rgb(210,21,21);
  --color-background-default:   rgb(232,246,246);
}

.SPH {
  --color-base: var(--color-sph-base);
  --color-accent-1: var(--color-sph-accent-1);
  --color-accent-1-dark: var(--color-sph-accent-1-dark);
  --color-accent-2: var(--color-sph-accent-2);
  --color-button: var(--color-sph-base);
  --color-button-hover: var(--color-sph-accent-1);
  --color-table: var(--color-sph-table);
}

.cta {
  @include button-default;
}

.container {
  padding: var(--space-medium) var(--dynamic-spacing-large);
}

main > section {
  background-color: white;
  z-index: 0;

  &:only-child {
    flex: 1;
  }
}

h1, h2, h3 {
  font-weight: 600;
}

h1 {
  font-size: 2rem;
}

h2, h3 {
  font-size: 1.25rem;
}

h1, h2, h3, a {
  color: var(--color-base);
}

h1:first-child, h2:first-child, section > h2  {
  margin-block-start: 0;
}

.richtext {
  max-width: var(--max-text-width);

  h1 {
    margin-block-end: 0;
  }

  img {
    width: 100%;
    height: unset;
    object-fit: contain;
    display: block;
    background-color: #F7F7F7;
    padding: 1rem;
    margin: 2rem 0;
    max-height: 25rem;
  }

  .large img {
    max-height: 50rem;
  }
}

.screen-reader-only {
  position: absolute !important;
  width: 1px !important;
  height: 1px !important;
  padding: 0 !important;
  margin: -1px !important;
  overflow: hidden !important;
  clip: rect(0, 0, 0, 0) !important;
  white-space: nowrap !important;
  border: 0 !important;
}

.sidebar  {
  --sidebar-gap: var(--space-medium);
  --header-width: calc(50vw + var(--card-width) / 2 + var(--card-gap) / 2);
  --article-width: calc(var(--header-width) - var(--dynamic-spacing-medium) - var(--sidebar-gap));
  display: grid;
  gap: var(--sidebar-gap);
  grid-template-columns: 1fr;

  @include screen-fits-two-cards {
    grid-template-columns: var(--article-width) 1fr;
  }

  > ul, > nav > ul  {
    display: flex;
    flex-direction: column;
    margin: 0;
    padding: 0;
    gap: 3rem;

    li {
      display: block;

      > h1:first-child, h2:first-child {
        margin-block-start: 0;
      }

    }
  }
}

.chart-wrapper, .table-wrapper {
  width: var(--max-text-width);
  overflow-x: auto;

  > table {
    width: 100%;
  }
}

table {
  border-collapse: collapse;
  background-color: white;
}

th, td {
  text-align: left;
  padding: 0.25rem .5rem;
}

th {
  background-color: var(--color-accent-1);
  border: 1px solid var(--color-base);
  color: white;
  hyphens: auto;
}

td {
  border: 1px solid #d4d4d4;
}

td.nowrap {
  white-space: nowrap;
}

.chart-wrapper, tbody tr:nth-child(even) td  {
    background-color: var(--color-table);
}

</style>
