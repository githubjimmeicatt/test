<template>
    <div id="view--Pensioen" class="container">
        <div class="content-section">
            <h2>Mijn pensioen</h2>

            <p>U kunt uw pensioenoverzicht bekijken op <a target="_blank" href="//www.mijnpensioenoverzicht.nl">mijnpensioenoverzicht.nl</a>.</p>

            <a class="logo-link" target="_blank" href="//www.mijnpensioenoverzicht.nl">
                <img :src="require('../assets/mijnpensioenoverzicht.png')"/>
            </a>

            <div v-if="$store.state.pension && $store.state.pension.IsActief">
                <p>Meer inzicht in je financiële situatie en pensioen? Maak een berekening op <a target="_blank" href="//www.pensioenpod.nl">Pensioenpod.nl</a>.</p>

                <a class="logo-link" target="_blank" href="//www.pensioenpod.nl">
                    <img :src="require('../assets/pensioenpod.svg')"/>
                </a>
            </div>

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
