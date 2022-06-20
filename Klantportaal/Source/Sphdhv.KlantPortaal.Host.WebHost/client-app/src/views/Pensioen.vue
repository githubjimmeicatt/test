<template>
    <div id="view--Pensioen" class="container">
        <div class="content-section">
            <h2>Mijn pensioen</h2>

            <p>U kunt uw pensioenoverzicht bekijken op <a target="_blank" href="//www.mijnpensioenoverzicht.nl">mijnpensioenoverzicht.nl</a>.</p>

            <a class="logo-link" target="_blank" href="//www.mijnpensioenoverzicht.nl">
                <img :src="require('../assets/mijnpensioenoverzicht.png')" />
            </a>

            <article>
                <p>Tot voor kort stelden wij de tool PensioenPod beschikbaar om je te helpen meer inzicht in je financi&#235;le situatie bij pensionering te krijgen.</p>
                <p>Omdat de tool niet aan de verwachtingen voldeed hebben we besloten de toegang tot deze tool van onze website te verwijderen.</p>
                <p>We verwijzen je naar je UPO voor meer inzicht in je pensioen bij ons pensioenfonds en naar <a href="//www.mijnpensioenoverzicht.nl" target=”_blank”>www.mijnpensioenoverzicht.nl</a> voor meer inzicht in het totale pensioen dat je al opgebouwd hebt en het verwachte pensioenbedrag na pensionering, inclusief de AOW. En natuurlijk kan je altijd bij ons <a href="https://www.pensioenfondshaskoningdhv.nl/Home/Over-het-pensioenfonds/Pensioenbureau" target=”_blank”>Pensioenbureau</a> terecht voor vragen over je pensioen.</p>
            </article>

        </div>
    </div>
</template>

<script>
    export default {
        name: 'Pensioen',
        async mounted() {
            const { $store } = this;
            if (!$store.state.pension)
                $store.dispatch('fetchPension');
        }
    }
</script>
