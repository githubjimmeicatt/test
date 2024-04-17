<template>
  <section
    v-if="cards?.length || $slots.cards"
    :class="['container cards', nrOfColumns == '4' ? 'four' : nrOfColumns == '3' ? 'three' : 'two']"
  >
    <div class="strip">
      <div class="stripIntro">
        <h1
          v-if="title"
        >
          {{ title }}
        </h1>
        <p
          v-if="intro"
        >
          {{ intro }}
        </p>
      </div>
    </div>
    <ul :class="['strip']">
      <li
        v-for="(x, i) in cards"
        :key="i"
      >
        <slot
          name="card"
          :card="x"
        >
          <card v-bind="x" />
        </slot>
      </li>
    </ul>
    <link-list
      :title="labelExtraUrls"
      :links="extraUrls"
    />
  </section>
</template>

<script>
import Card from './Card.vue'
import LinkList from './LinkList.vue'

export default {
  components: { Card, LinkList },
  props: {
    nrOfColumns: {
      type: String,
      default: '3',
    },
    title: {
      type: String,
      default: '',
    },
    intro: {
      type: String,
      default: '',
    },
    cards: {
      type: Array,
      default: () => [],
    },
    link: {
      type: Object,
      default: null,
    },
    labelExtraUrls: {
      type: String,
      default: null,
    },
    extraUrls: {
      type: Array,
      default: () => [],
    },
  },
}
</script>

<style lang="scss" scoped>
@import "../assets/scss/_mixins.scss";

ul {
  margin: 0;
  padding: 0;
}

::v-deep(li) {
  display: block;
}

p {
  margin-block-end: var(--space-medium);
}

.strip {
  display: grid;
  gap: var(--space-medium);
  grid-template-columns: 1fr;
  justify-content: center;
  align-content: start;
  width: 100%;
}

.stripIntro{
  grid-column: 1 /-1;
  max-width: var(--max-text-width);
}

.cta {
  align-self: flex-start;
  justify-self: flex-start;
  margin-top: var(--card-gap);
}

 .strip {
    grid-template-columns: 651px;

     :deep(img) {
      height: 217px;
     }

    @include mobile {
        :deep(img) {
          height: 130px;
        }
      }

    @include screen-fits-two-cards {
       :deep(img) { height: 188px;
       }
    }

    @include screen-fits-three-cards {
      :deep(img) {  height: 122px;
      }
     }
 }

 .two .strip {
    grid-template-columns: 651px;

     :deep(img) {
      height: 217px;
     }

    @include mobile {
        :deep(img) {
          height: 130px;
        }
      }

    @include screen-fits-two-cards {
       :deep(img) { height: 188px;
       }
    }

    @include screen-fits-three-cards {
      :deep(img) {  height: 188px;
      }
     }
 }

@include screen-fits-two-cards {
   .two .strip, .strip {
      grid-template-columns: 564px 564px;
    }
  }

  @include screen-fits-three-cards {
    .three, .four {
      .strip {
        grid-template-columns: 366px 366px 366px;
      }
    }
  }

  @include mobile {
    .strip {
     grid-template-columns: 390px;
    }
  }

</style>
