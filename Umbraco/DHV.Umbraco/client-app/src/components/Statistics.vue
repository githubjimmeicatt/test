<template>
  <section
    v-if="title || subtitle || statistics?.length"
    class="container"
  >
    <div
      v-if="title || subtitle"
      class="strip"
    >
      <div class="stripIntro">
        <h2>
          {{ title }}
        </h2>
        <p>
          {{ subtitle }}
        </p>
      </div>
    </div>
    <section
      v-if="statistics?.length"
      class="strip"
    >
      <article
        v-for="(item, index) in statistics"
        :key="index"
      >
        <h1>{{ item.value }}</h1>
        <span>{{ item.label }}</span>
      </article>
    </section>
  </section>
  <!-- https://localhost:44395/gezinsvormen/voltijd-of-deeltijd-pleegouder-worden/ -->
</template>

<script>

export default {
  components: { },
  props: {
    contentTypeAlias: {
      type: String,
      default: '',
    },
    title: {
      type: String,
      default: '',
    },
    subtitle: {
      type: String,
      default: '',
    },
    statistics: {
      type: Array,
      default: () => [],
    },
  },
}
</script>

<style lang="scss" scoped>
@import "../assets/scss/_mixins.scss";

//todo: styling strip en intro gelijktrekken met cards, eventueel ook linklist
 .strip {
  display: inline-grid;
  gap: var(--space-medium);
  grid-template-columns: 1fr;
  justify-content: center;
  align-content: start;
  width: 100%;

}

.stripIntro{
  grid-column: 1 /-1;
  max-width: 50rem;
}

h1, h2{
  margin-block-end: 0;
}

article{
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

@include screen-fits-two-cards {
    .strip {
      grid-template-columns: repeat(2, var(--card-width-large));
    }
  }

@include screen-fits-three-cards {
  .strip {
    grid-template-columns: repeat(3, var(--card-width));
  }
}

@include screen-fits-four-cards {
  .strip {
    grid-template-columns: repeat(4, var(--card-width-small));
  }
}

</style>
