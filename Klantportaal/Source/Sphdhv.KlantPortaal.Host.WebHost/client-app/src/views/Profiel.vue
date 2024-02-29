<template>
    <div id="view--Profiel" class="container">
        <div class="content-section">
            <h2>Mijn profiel</h2>

            <KeyValueList
                :labels="labels"
                :object="$store.state.user"
            />

            <div v-if="$store.state.user.HuidigePartner">
                <br/>
                <KeyValueList
                    :labels="partnerLabels"
                    :object="$store.state.user.HuidigePartner"
                />
            </div>
        </div>
    </div>
</template>

<script>
    import KeyValueList from '@/components/generic/KeyValueList.vue';

    export default {
        name: 'Profiel',
        components: {
            KeyValueList
        },
        data: () => {
            return {
                partnerLabels: {
                    NaamVolledig: 'Naam partner',
                    DatumGeboorte: 'Geboortedatum partner'
                },
                labels: {
                    Naam: 'Naam',
                    DatumGeboorte: 'Geboortedatum',
                    Geslacht: 'Geslacht',
                    Bsn: 'BSN',
                    Burgerlijkestaat: 'Burgerlijke staat'
                }
            }
        }
    }
</script>
