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
                <div v-if="$store.getters.isAuthenticated">
                    <a href="/authentication/logoff">
                        <SvgIcon icon="exit"/>
                        Uitloggen
                    </a>
                </div>
            </div>
        </div>
        <div v-if="$store.getters.isAuthenticated" class="Masthead--bottom">
            <nav class="container">
                <ul>
                    <li>
                        <router-link :to="{name: 'Profiel'}">
                            <SvgIcon icon="user"/>
                            Profiel
                        </router-link>
                    </li>
                    <li>
                        <router-link :to="{name: 'Pensioen'}">
                            <SvgIcon icon="piggy-bank"/>
                            Pensioen
                        </router-link>
                    </li>
                    <li>
                        <router-link :to="{name: 'Documenten'}">
                            <SvgIcon icon="document"/>
                            Documenten
                        </router-link>
                    </li>
                </ul>
            </nav>
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
