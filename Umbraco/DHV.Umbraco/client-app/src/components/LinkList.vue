<template>
  <h3
    v-if="title"
    class="row"
  >
    {{ title }}
  </h3>
  <ul
    v-if="links.length"
    class="row"
  >
    <li
      v-for="({ url, name }, i) in links"
      :key="i"
    >
      <router-link
        class="arrow-before link"
        :to="url"
      >
        {{ name }}
      </router-link>
    </li>
  </ul>
</template>

<script>
export default {
  props: {
    title: {
      type: String,
      default: null,
    },
    links: {
      type: Array,
      default: () => [],
    },
  },
}
</script>

<style lang="scss" scoped>
@import "../assets/scss/_mixins.scss";

h3{
    margin-top: var(--space-medium);
    font-variant: all-small-caps;
    margin-bottom: calc(-1*var(--space-medium) + var(--space-small));
}

@include screen-fits-two-cards {
    .row{
        margin-left: auto;
        margin-right: auto;
        width: calc(2 *var(--card-width-large) + var(--space-medium));
    }
}

@include screen-fits-three-cards {
    .three, .four {
    .row{
        margin-left:0px;
        margin-right:0px;
        width: calc(3 *var(--card-width-small));
    }
    }
}

@include screen-fits-four-cards {
    .four {
    .row{
        margin-left:0px;
        margin-right:0px;
        width: calc(4 *var(--card-width-small));
    }
    }
}

.row{
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    justify-content: flex-start;
    margin-top: var(--space-medium);
    gap: var(--space-small);
    padding:0px;
}

.row > li {
    position:relative;
    background-color: var(--color-base);
    padding: var(--space-smallest) var(--space-small) var(--space-smallest) var(--space-small);
    border-radius:20px;
    flex-wrap: wrap;
}

.row .link {
    text-decoration: none;
    color: white;
}

</style>
