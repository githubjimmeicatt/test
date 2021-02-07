<template>
    <div class="container content-section">
        home
    </div>
</template>

<script>
    import SvgIcon from '@/components/generic/SvgIcon';

    export default {
        name: 'Home',
        components: {
            SvgIcon
        },
        mounted() {
            const { $store, $router } = this;
            if (!$store.getters.isLoggedIn) {
                $router.push({name: 'Login'});
            }
        }
    }
</script>
