<template>
    <div id="view--Documenten" class="container">
        <div class="content-section">
            <h2>Mijn documenten</h2>

            <table v-if="documents.length > 0">
                <tbody>
                    <tr :key="document.Id" v-for="document in documents">
                        <td><strong>{{document.Titel}}</strong></td>
                        <td>{{document.MutatieDatum}}</td>
                        <td class="align-right">
                            <a :href="`${document.url}OpenFile?documentId=${document.Id}`" target="_blank">
                                <SvgIcon icon="download"/>
                                Download
                            </a>
                        </td>
                    </tr>
                </tbody>
            </table>

            <span v-else class="no-results-message">
                Er zijn geen documenten.
            </span>
        </div>
    </div>
</template>

<script>
    import SvgIcon from '@/components/generic/SvgIcon'

    export default {
        name: 'Documenten',
        components: { SvgIcon },
        computed: {
            documents() {
                const { $store } = this;
                return $store.state.documents?.items || [];
            }
        },
        async mounted() {
            const { $store } = this;
            if (!$store.state.documents)
                $store.dispatch('fetchDocuments');
        }
    }
</script>
