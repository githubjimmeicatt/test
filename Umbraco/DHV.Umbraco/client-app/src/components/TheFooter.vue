<template>
  <footer>
    <ul class="footermenu">
      <li>
        <site-logo class="stacked" />
      </li>
      <li>
        <ul>
          <li class="contact-icon phone">
            088 348 2190<br />
            ( 9.00 - 17.00 uur )
          </li>
          <li class="contact-icon envelope">
            <the-link href="pensioenfonds@rhdhv.com">
              pensioenfonds@rhdhv.com
            </the-link>
          </li>
        </ul>
      </li>
      <li>
        <ul>
          <li>
            <address>
              <span>Laan 1914 nr. 35</span>
              <span>3818 EX Amersfoort</span>
            </address>
          </li>
          <li>
            <address>
              <span>Postbus 1388</span>
              <span>3800 BJ Amersfoort</span>
            </address>
          </li>
        </ul>
      </li>
    </ul>

    <ul
      v-if="menu?.length"
      class="footermenu"
    >
      <li
        v-for="({
          href, title, children, contentTypeAlias,
        }, key) in filteredMenu"
        :key="key"
      >
        <h2>
          <span v-if="contentTypeAlias === 'contentGroup'">
            {{ title || href }}
          </span>

          <router-link
            v-else-if="href"
            :to="href"
          >
            {{ title || href }}
          </router-link>
        </h2>
        <ul v-if="children?.length">
          <li
            v-for="(child, childKey) in children"
            :key="`${key}_${childKey}`"
          >
            <router-link
              v-if="child?.href"
              :to="child.href"
            >
              {{ child.title || child.href }}
            </router-link>
          </li>
        </ul>
      </li>
    </ul>
    <span class="copyright">{{ copyright }}</span>
  </footer>
</template>

<script>
import { computed } from 'vue'
import SiteLogo from './SiteLogo.vue'
import TheLink from './TheLink.vue'

export default {
  components: {
    SiteLogo,
    TheLink,
  },
  props: {
    menu: {
      type: Array,
      default: () => [],
    },
  },
  setup(props) {
    const filteredMenu = computed(() => props.menu.filter((x) => x.showInMenu).map((x) => ({
      ...x,
      children: x.children.filter((c) => c.showInMenu),
    })))

    return {
      filteredMenu,
      copyright: `© ${window.UMBRACO_PORTAL?.footerName || ''} ${new Date().getFullYear()}`,
    }
  },
}
</script>

<style lang="scss">
@import "../assets/scss/_mixins.scss";

footer {
  display: flex;
  flex-direction: column;
  gap: 3rem;
  background-color: var(--color-base);
  color: white;
  padding: var(--space-medium) var(--dynamic-spacing-medium);

  a,
  span {
    color: white;
  }

  a {
    text-decoration: none;
    &:hover {
      cursor: pointer;
      text-decoration: underline;
    }
  }

  ul {
    list-style: none;
    margin: 0;
    padding: 0;
    display: flex;
    flex-direction: column;
    gap: var(--space-smallest);
  }

  .footermenu {
    width: 100%;
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(16rem, 1fr));
    gap: 3rem;

    @include screen-fits-two-cards {
      grid-template-columns: repeat(5, 1fr);
    }

    li {
      padding-block: 0.125rem;

      &.contact-icon {
        @include contact-icons;
      }
    }

    address {
      font-style: normal;

      span {
        display: block;
      }
    }
  }

  .copyright {
    text-align: center;
    margin-right: auto;
    margin-left: auto;
    display: block;
    opacity: 75%;
  }
}
</style>
