<template>

  <article>
    <img src="https://media.umbraco.io/dev-pensioenfonds-haskoningdhv/z0aomswh/geldboom.png" alt="quote afbeelding" />
    <div>
      <p>de tekst van de qudfgdf  fghfghd fhshdfgshdfgdf  fghfghd fhshdfgshdfgdf  fghfghd fhshdfgshdfgdf  fghfghd fhshdfgshdfgdf  fghfghd fhshdfgshdfgdf  fghfghd fhshdfgshdfgdf  fghfghd fhshdfgshdfgdf  fghfghd fhshdfgshdfgdf  fghfghd fhshdfgshdfgdf  fghfghd fhshdfgshote. mooie woorgdfgdf  fghfghd fhshdfgshgd fhsgdjh </p>
      <div><span>auteur</span><a href="#">optionele link</a></div>
    </div>
  </article>
</template>

<script>

export default {

  props: {
    contentTypeAlias: {
      type: String,
      default: '',
    },
    tekst: {
      type: String,
      default: '',
    },
    auteur: {
      type: String,
      default: '',
    },
    afbeelding: {
      type: String,
      default: '',
    },
    link: {
      type: Object,
      default: null,
    },

  },
}
</script>

<style lang="scss" scoped>
@import "../assets/scss/_mixins.scss";

article{
    display: flex;
    width:100%;
    gap: var(--space-smaller);
}

article > div{
border-bottom: 3px solid #dcd7d7;
 box-shadow: 0 2px 0.3rem rgb(0 0 0 / 9%);

  background-color: var( --color-background-standout);
  border-radius: var( --border-radius-medium);;
  padding: var(--space-medium);

   display: flex;
   flex-direction: column;
    justify-content: space-between;
    gap: var(--space-medium);
//   color: black;
//   display: flex;
//   flex-direction: column;
//   overflow: hidden;
//   height: 100%;
//   border-radius: 0 0 0.75rem 0.75rem;
//   box-shadow: 0 0 0.625rem rgba(0, 0, 0, 0.25);
    p{
        padding: 0px;
        margin: 0px;;
        font-style: italic;
    }

    div{
        display: flex;
        justify-content: space-between;
    flex-direction: row;

            padding: 0px;

    }
}

 img{
    width: 100%;
    border-radius: 50%;
    border: 1px solid transparent;
    width: 128px;
    height:128px;
    margin-block-start: var(--space-smaller);
    // height: 217px;

    // @include mobile {
    //     .strip {
    //       height: 130px;
    //     }
    //   }

    // @include screen-fits-two-cards {
    //   height: 188px;
    // }

    // @include screen-fits-three-cards {
    //   height: 122px;
    //  }

    object-position: center;
    object-fit: cover;
  }

  ::v-deep(h1) {
    font-size: 1.25rem;
    margin: 0;
  }

  ::v-deep(.subtitle) {
    text-transform: capitalize;
    margin-block: var(--space-smaller);
  }

  .article-inner{
    padding: 1.5rem;
  }

</style>
