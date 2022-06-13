<template>
    <div class="container">
        <div class="content-section">
            <h1>Inloggen met DigiD</h1>
            <p>Met MijnPensioenfondsHaskoningDHV heb je altijd inzicht in je actuele pensioensituatie.</p>

            <article>
                <p>Tot voor kort stelden wij de tool PensioenPod beschikbaar om je te helpen meer inzicht in je financi&#235;le situatie bij pensionering te krijgen.</p>
                <p>Omdat we onvoldoende feedback van PensioenPod kregen over aantallen en gebruik van de tool om vast te stellen of de tool aan de verwachtingen voldeed hebben we besloten de toegang tot deze tool van onze website te verwijderen.</p>
                <p>We verwijzen je naar je UPO voor meer inzicht in je pensioen bij ons pensioenfonds en naar <a href="//www.mijnpensioenoverzicht.nl" target=”_blank”>mijn pensioenoverzicht</a> voor meer inzicht in het totale pensioen dat je al opgebouwd hebt en het verwachte pensioenbedrag na pensionering, inclusief de AOW. En natuurlijk kan je altijd bij ons <a href="https://www.pensioenfondshaskoningdhv.nl/Home/Over-het-pensioenfonds/Pensioenbureau" target=”_blank”>Pensioenbureau</a> terecht voor vragen over je pensioen.</p>
            </article>

            <a class="digid" href="/authentication/login">
                <img src="../assets/digid.png" />
                <span>
                    Inloggen met DigiD
                </span>
            </a>

            <ul class="link-list">
                <li>
                    <a href="https://www.digid.nl/" target="_blank">
                        <SvgIcon icon="chevron-right" />
                        Vraag je DigiD aan
                    </a>
                </li>
                <li>
                    <a href="https://www.digid.nl/vraag-en-antwoord" target="_blank">
                        <SvgIcon icon="chevron-right" />
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
