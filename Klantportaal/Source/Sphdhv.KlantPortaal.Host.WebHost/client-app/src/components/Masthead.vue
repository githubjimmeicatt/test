<template>
    <header class="Masthead">
        <div class="Masthead--top">
            <div class="container">
                <a href="https://www.pensioenfondshaskoningdhv.nl/">
                    <SvgIcon icon="arrow-left"/>
                    pensioenfondshaskoningdhv.nl
                </a>
            </div>
        </div>
        <div class="Masthead--main">
            <div class="container">
                <div aria-label="Pensieonfonds HaskoningDHV">
                    <img alt="" class="logo-large" src="../assets/logo-large.svg"/>
                    <img alt="" class="logo-small" src="../assets/logo-small.svg"/>
                </div>
                <div v-if="$store.getters.isLoggedIn">
                    <a href="/authentication/logoff">
                        <SvgIcon icon="exit"/>
                        Uitloggen
                    </a>
                </div>
            </div>
        </div>
    </header>
</template>

<script>
import SvgIcon from '@/components/generic/SvgIcon';

export default {
    components: {
        SvgIcon
    }
}
</script>
