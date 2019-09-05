namespace Sphdhv.KlantPortaal.Host.WebHost
{
    public enum KlantportaalDigidAssertionEndpoint : byte
    {
        DhvDnnAccept = 0,
        DhvKlantportaalAccept = 1,
        IcattKlantportaalAccept = 2,
        DnnHostLokaal = 3,
        KlantportaalLokaal = 4,
        AaDhvKlantportaalAccept = 5,
        AaIcattKlantportaalAccept = 6,
        OoDhvKlantportaalAccept = 7,
        OoIcattKlantportaalAccept = 8,
    }

}
