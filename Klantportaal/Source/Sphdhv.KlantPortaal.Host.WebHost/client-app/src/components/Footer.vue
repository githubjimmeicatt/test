<template>
    <footer class="Footer">
        <div class="container">
            <ul>
                <li>
                    <SvgIcon icon="location"/>
                    Laan 1914 nr. 35 3818 EX Amersfoort<br/>
                    Postbus 1388 3800 BJ Amersfoort
                </li>
                <li>
                    <SvgIcon icon="phone"/>
                    (088) 348 2190
                </li>
                <li>
                    <a href="mailto:pensioenfonds@rhdhv.com">
                        <SvgIcon icon="mail"/>
                        pensioenfonds@rhdhv.com
                    </a>
                </li>
            </ul>
        </div>
    </footer>
</template>

<script>
import SvgIcon from '@/components/generic/SvgIcon.vue';

export default {
    components: {
        SvgIcon
    }
}
</script>
