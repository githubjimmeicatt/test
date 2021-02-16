<template>
    <div class="container">
        <div class="content-section">
            <h1>Inloggen met DigiD</h1>
            <p>Met MijnPensioenfondsHaskoningDHV heb je altijd inzicht in je actuele pensioensituatie.</p>

            <a class="digid" href="/authentication/login">
                <img src="../assets/digid.png"/>
                <span>
                    Inloggen met DigiD
                </span>
            </a>

            <ul class="link-list">
                <li>
                    <a href="https://www.digid.nl/" target="_blank">
                        <SvgIcon icon="chevron-right"/>
                        Vraag je DigiD aan
                    </a>
                </li>
                <li>
                    <a href="https://www.digid.nl/vraag-en-antwoord" target="_blank">
                        <SvgIcon icon="chevron-right"/>
                        Veelgestelde vragen over DigiD
                    </a>
                </li>
            </ul>

            <p>Heb je een vraag over DigiD en staat deze niet bij de veelgestelde vragen? Neem dan contact op met de <a href="https://www.digid.nl" target="_blank">DigiD-helpdesk</a>.</p>
        </div>
    </div>
</template>

<script>
    import SvgIcon from '@/components/generic/SvgIcon';

    export default {
        name: 'Login',
        components: {
            SvgIcon
        }
    }
</script>
