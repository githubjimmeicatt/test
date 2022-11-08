<template>
  <router-link
    class="logo"
    to="/"
    aria-label="logo"
  >
    <span>Pensioenfonds</span>
    <span>HaskoningDHV</span>
  </router-link>
</template>

<style lang="scss" scoped>
@import "../assets/scss/_mixins.scss";

.logo {
  display: flex;
  flex-direction: column;
  color: white;
  background: var(--color-base);

  @include screen-fits-two-cards {
    flex-direction: row;
    gap: var(--space-smallest);
    font-size: 1.5rem;
  }

  &,
  &:hover {
    text-decoration: none;
  }

  :first-child {
    font-weight: 500;
  }

  :last-child {
    font-weight: 300;
    letter-spacing: 1px;
  }
}
</style>
