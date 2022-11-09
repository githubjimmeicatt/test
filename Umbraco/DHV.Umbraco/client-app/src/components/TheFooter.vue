<template>
  <footer>
    <ul class="footermenu">
      <li>
        <site-logo class="stacked" />
      </li>
      <li>
        <ul>
          <li class="contact-icon phone">+31 6 12345678</li>
          <li class="contact-icon linkedin">example@email.nl</li>
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
        v-for="({ href, title, children }, key) in menu"
        :key="key"
      >
        <h2>
          <router-link
            v-if="href"
            :to="href || '#'"
          >
            {{ title || href }}
          </router-link>
        </h2>
        <ul v-if="children?.length">
          <li
            v-for="(child, childKey) in getSortedChildren(children, title)"
            :key="`${key}_${childKey}`"
          >
            <router-link
              v-if="child?.href"
              :to="child.href || '#'"
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
import SiteLogo from './SiteLogo.vue'

export default {
  components: {
    SiteLogo,
  },
  props: {
    menu: {
      type: Array,
      default: () => [],
    },
  },
  setup() {
    return {
      copyright: `© ${window.UMBRACO_PORTAL?.footerName || ''} ${new Date().getFullYear()}`,
      getSortedChildren: (children, title) => {
        if (!title || title.toUpperCase() != 'NIEUWS') { return children }

        if (!Array.isArray(children)) { return children }

        return children.sort((a, b) => {
          if (!a || !b) {
            return 0
          }

          let compareDateA = Date.parse(a.updateDate)
          if (isNaN(compareDateA)) {
            compareDateA = Date.parse(a.createDate)
          }
          if (isNaN(compareDateA)) {
            return 1
          }

          let compareDateB = Date.parse(b.updateDate)
          if (isNaN(compareDateB)) {
            compareDateB = Date.parse(b.createDate)
          }
          if (isNaN(compareDateB)) {
            return -1
          }

          return compareDateB - compareDateA
        })
      },
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

  a {
    color: white;
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
      padding: 0.125rem 0;

      &.contact-icon {
        @include contact-icons();
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
