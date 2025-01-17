<template>
  <header :class="headerClasses">
    <search-bar
      ref="searchBar"
      class="header-search-bar"
    />
    <nav>
      <ul ref="ulEl">
        <li class="logo">
          <site-logo />
        </li>

        <router-link
          v-for="({
            href, title, children, contentTypeAlias,
          }, key) in filteredMenu"
          :key="key"
          v-slot="{ navigate, isActive, isExactActive }"
          :to="href || '#'"
          custom
        >
          <li
            :class="{
              'router-link-active': isActive,
              'router-link-exact-active': isExactActive,
              children,
              navItem: true,
              open: isOpen(key),
              'has-submenu': (children && children.length > 0),
            }"
            @mouseenter="open(key)"
            @focusin="contentTypeAlias !== 'contentGroup' && open(key)"
            @mouseleave="close(key)"
            @focusout="contentTypeAlias !== 'contentGroup' && close(key)"
          >
            <a
              v-if="contentTypeAlias === 'contentGroup'"
              :href="'#'"
              @click.prevent="toggleOpen(key)"
            >{{ title }}</a>

            <a
              v-else
              :href="href || '#'"
              @click.prevent="closeHamburger(navigate)"
            >{{ title }}</a>

            <template v-if="children?.length">
              <button
                :aria-label="`menu-toggle-for-${title}`"
                :aria-expanded="isOpen(key)"
                type="button"
                @click="toggleOpen(key)"
              >
                <ChevronDown />
              </button>
              <ul @mouseenter="enterSub(key)" @focusin="enterSub(key)">
                <router-link
                  v-for="(childItem, childIndex) in children"
                  :key="`${key}_${childIndex}`"
                  v-slot="{ navigate, isActive, isExactActive }"
                  :to="childItem.href || '#'"
                  custom
                >
                  <li
                    :class="{
                      'router-link-active': isActive,
                      'router-link-exact-active': isExactActive,
                    }"
                  >
                    <a
                      :href="childItem.href || '#'"
                      @click.prevent="closeHamburger(navigate)"
                    > {{ childItem.title }}</a>
                  </li>
                </router-link>
              </ul>
            </template>
          </li>
        </router-link>

        <li class="hamburger">
          <button
            aria-label="Menu uitklappen"
            type="button"
            @click="toggleHamburgerExpanded"
          >
            <span />
          </button>
        </li>
      </ul>
    </nav>
  </header>
</template>

<script>
import {
  ref, computed, watch, inject, nextTick,
} from 'vue'
import { useRoute } from 'vue-router'

import { useMediaQuery, useResizeObserver } from '@vueuse/core'
import ChevronDown from '../assets/chevron-down.svg'
import SearchBar from './SearchBar.vue'
import SiteLogo from './SiteLogo.vue'

/**
 *
 * @param {Element} el
 */
function checkIfWrapped(el) {
  const all = el.children
  // zijn er minder dan twee navItems, dan kunnen we niks vergelijken
  if (all.length < 2) return false

  let previous

  // eslint-disable-next-line no-restricted-syntax
  for (const current of all) {
    // eslint-disable-next-line no-continue
    if (!(current instanceof HTMLElement) || current.classList.contains('hamburger')) continue
    if (previous && previous instanceof HTMLElement && previous.offsetLeft > current.offsetLeft) {
      return true
    }
    previous = current
  }

  return false
}

export default {
  components: {
    ChevronDown,
    SearchBar,
    SiteLogo,
  },
  setup() {
    const route = useRoute()
    const menu = inject('menu')
    const hamburgerExpanded = ref(false)
    const searchExpanded = ref(false)
    const ulEl = ref(null)
    const isWrapped = ref(false)

    useResizeObserver(ulEl, ([e]) => {
      // zoek alle navItems
      isWrapped.value = checkIfWrapped(e.target)
    })

    const isMobile = useMediaQuery('(max-width: 500px)')
    const hamburgerEnabled = computed(() => isMobile.value || isWrapped.value || hamburgerExpanded.value)
    const openSubmenu = ref(-1)

    const filteredMenu = computed(() => menu.value.filter((x) => x.showInMenu).map((x) => ({
      ...x,
      children: x.children.filter((c) => c.showInMenu),
    })))

    function toggleHamburgerExpanded() {
      const newVal = !hamburgerExpanded.value
      if (newVal) {
        searchExpanded.value = false
      }
      hamburgerExpanded.value = newVal
    }

    function closeHamburger(navigate) {
      hamburgerExpanded.value = false
      if (navigate) {
        navigate()
      }
    }

    const searchBar = ref(null)

    function toggleSearchExpanded() {
      const newVal = !searchExpanded.value
      searchExpanded.value = newVal
      if (newVal) {
        hamburgerExpanded.value = false
        nextTick(() => searchBar.value.focus())
      }
    }

    function reset() {
      openSubmenu.value = -1
      hamburgerExpanded.value = false
    }

    watch([() => route.name, () => route.path], ([routeName]) => {
      reset()
      searchExpanded.value = routeName === 'Search'
    }, { immediate: true })

    watch(hamburgerEnabled, (isEnabled) => {
      if (!isEnabled) {
        hamburgerExpanded.value = false
      }
    })

    const headerClasses = computed(() => ({
      header: true,
      hamburgerExpanded: hamburgerExpanded.value,
      hamburgerEnabled: hamburgerEnabled.value,
      searchExpanded: searchExpanded.value,
    }))

    const menuTimeouts = {}

    const toggleOpen = (i) => {
      clearTimeout(menuTimeouts[i])
      openSubmenu.value = openSubmenu.value === i ? -1 : i
    }

    const open = (i) => {
      if (!hamburgerExpanded.value) {
        clearTimeout(menuTimeouts[i])
        openSubmenu.value = i
      }
    }

    const close = (key) => {
      menuTimeouts[key] = setTimeout(() => {
        if (openSubmenu.value === key) {
          openSubmenu.value = -1
        }
      }, 100)
    }

    const enterSub = (key) => {
      clearTimeout(menuTimeouts[key])
    }

    return {
      filteredMenu,
      hamburgerEnabled,
      headerClasses,
      ulEl,
      hamburgerExpanded,
      toggleHamburgerExpanded,
      closeHamburger,
      toggleSearchExpanded,
      searchBar,
      isOpen(i) {
        return openSubmenu.value === i
      },
      toggleOpen,
      reset,
      close,
      enterSub,
      open,
    }
  },
}
</script>

<style lang="scss">
@import "../assets/scss/_mixins.scss";

.search-button {
  position: absolute;
  z-index: 1;
  // container + breedte van hamburger + margin
  right: var(--dynamic-spacing-medium);
  top: calc(0.5 * var(--logo-height) + var(--border-height));
  transform: translateY(-50%);
}

.header {
  --timing: 0.3s;
  --header-height: 60px;
  --logo-height: 52px;
  --logo-reset: -5px;
  --border-height: var(--space-smallest);

  z-index: 1;

  button:hover {
    cursor: pointer;
  }

  li.logo {
    padding-left: var(--dynamic-spacing-medium);
    background-color: var(--color-base);
    flex: 1;
    padding-top: var(--border-height);
    padding-bottom: var(--border-height);
    height: calc(var(--logo-height) + (2 * var(--border-height)));
  }

  nav {
    flex-grow: 1;
    background: var(--color-base);
    margin: 0;
    color: white;
    font-size: 1.125rem;

    a {
      color: inherit;
      text-decoration: none;
      display: flex;

      &:hover {
        text-decoration: underline;
      }
    }

    .navItem.router-link-active {
      color: white;

      button > svg {
        fill: white !important
      }
    }

    .navItem ul li.router-link-active{
      background-color:white;
      color: var(--color-base);
    }

    ul {
      position: relative;
      padding: 0;
      margin: 0;
      transition: all var(--timing) ease-in-out;
      display: flex;
      flex-basis: unset;
      flex-wrap: wrap;
      min-height: 0;
      grid-auto-flow: column;
      align-items: center;
      align-content: baseline;

      li {
        display: flex;
        align-items: center;

        &.navItem:nth-last-child(2) {
          margin-right: var(--dynamic-spacing-medium);
        }

        &.search-button {
          button {
            background: none;
            margin: 0;

            border: none;
          }
          svg {
            fill: var(--color-base);
            width: 2.25rem;
            display: block;
          }
        }

        &.search {
          opacity: 100%;
        }

        &.navItem {
          position: relative;
          text-transform: lowercase;
          padding-top: var(--space-smallest);
          padding-bottom: var(--space-smaller);
          padding-right: var(--space-small);
          padding-left: var(--space-small);
          a {
            display: inline-block;
          }

          button {
            border: none;
            background: none;
            padding: 0;
            margin-left: var(--space-small);
            font-weight: 600;
            width: .75rem;

            > svg {
              fill: white;
            }
          }

          ul {
            display: inline-block;
            position: absolute;
            right: calc(-1 * var(--space-smallest));
            top: 0;
            margin-top: var(--space-medium);
            min-height: unset;
            max-height: 0;
            width: 20rem;
            transition: all var(--timing) ease-out;
            border: none;
            background-color: var(--color-base);
            z-index: 1;

            li {
              position: relative;
              opacity: 0;
              transition: opacity var(--timing) ease-in-out;
              color: white;
              padding-top: var(--space-smaller) ;
              padding-right: var(--space-small) ;
              padding-bottom: var(--space-smaller) ;
              padding-left: var(--space-small) ;
              position: relative;
              width: 100%;
              visibility: hidden;
            }
          }

          &.open {
            button > svg {
              transform: rotate(180deg);
            }

            ul {
              max-height: 100vh;
              box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
              padding-top:var(--space-smaller);
              padding-bottom: var(--space-smaller);
              &::before {
                opacity: 100%;
                transform: translateY(-100%);
              }

              li {

                opacity: 100%;
                visibility: visible;
                a:hover,a:active{
                  text-decoration: underline;
                }
              }
            }
          }
        }

      }
    }
  }

  .hamburger {
    display: none;
    position: absolute;
    z-index: 1;
    right: var(--dynamic-spacing-medium);
    top: calc(0.5 * var(--logo-height) + var(--border-height));
    transform: translateY(-50%);
    button {
      background: none;
      border: none;
      cursor: pointer;
      height: 2rem;
      width: 2rem;
      padding: 0;

      span {
        background-color: white;
        display: block;
        height: 0.22rem;
        position: relative;
        transition: background-color var(--timing) ease-out;
        width: 2rem;

        &:before,&:after{
          background-color: white;
          content: '';
          display: block;
          height: 100%;
          position: absolute;
          transition: all var(--timing) ease-out;
          width: 100%;
        }

        &:before {
          top: 0.8rem;
        }

        &:after {
          top: -0.8rem;
        }
      }
    }

  }
}

// DO NOT CHANGE ANY CSS THAT RESULTS IN A NEW WIDTH OF NAV ITEMS HERE.
// This will prevent correctly checking wether the desktop nav fits on the screen.
// You can safely make these changes below, in the expanded state.
.header.hamburgerEnabled {
  .hamburger {
    display: flex;
  }

  nav ul li.search-button {
    margin-right: 3rem;
  }

  li.navItem{
    visibility: collapse;
    min-width: 0;
    transition: min-width 1s var(--timing);
    height: 0;
    padding-top: 0;
    padding-bottom: 0;

    color: white;

    button {
      opacity: 0;
    }

  &.router-link-active{

      background-color: var(--color-base);

    }

    ul {
      display: none;
      position: unset;

      &::before {
        display: none;
      }
    }
  }

  ~ * {
    transition-property: all;
    transition-duration: 0.25s;
    transition-timing-function: ease-in-out;
    overflow: hidden;
  }
}

// ANY CHANGES RESULTING IN A DIFFERENT WIDTH OF NAV ITEMS GO HERE
.header.hamburgerEnabled.hamburgerExpanded {
  .hamburger button span {
    background-color: transparent;
    &:before{
      top: 0;
      transform: rotate(-45deg);
    }

    &:after {
      top: 0;
      transform: rotate(45deg);
    }
  }

  nav > ul {
    min-height: calc(100vh - var(--border-height));
    background-color: var(--color-accent-1);
    border-bottom: none;

    > li.navItem {
      margin-top: 16px;
      margin-left: 0;

      > a{
        font-size: 1.5rem;
      }

      button > svg{
        margin-top: var(--space-small);
        transform: scale(1.5);
      }
    }

    > .hamburger + li.navItem {
      margin-top: 0;
    }

    li.navItem {
      visibility: visible;
      height: unset;
      min-width: 100%;
      max-width: 100vw;
      transition: all var(--timing);
      display: block;
      padding-left: 0px;
      padding-right:0px;
      padding-top: var(--space-smallest);
      padding-bottom: var(--space-smaller);

      button {
        float: right;
        opacity: 100%;
      }

      &:nth-of-type(2) {
        margin-top: 3rem;
      }

      a:hover,a:active{
        filter: none;
      }

      &.open {
        background-color: var(--color-base);
        ul {
          margin-top: var(--space-smallest);
          display: inline-block;
          width: 100%;
          box-shadow: none;
        }
        button {
          > svg {
            fill: var(--color-accent-2);
          }
        }
      }

      ul {
        background: none;
        opacity: 100%;

        li {
          padding-left: var(--space-small);

        }
      }
    }

     li.navItem a {
       margin-left: var(--space-small);
     }

      li.navItem button {
       margin-right: var(--space-small);
     }
  }

  .breadcrumbs {
    display: none;
  }

  ~ * {
    max-height: 0;
    padding: 0;
    visibility: hidden;
  }
}

//search bar
.header-search-bar {
  max-width: 100vw;
  padding-right: var(--dynamic-spacing-large);
  padding-left: var(--dynamic-spacing-large);
  padding-block: var(--space-small);
  margin: 0;
  overflow: hidden;
  flex-wrap: wrap;
  align-items: center;
  gap: .5rem;
}
</style>
