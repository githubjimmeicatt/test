namespace Sphdhv.KlantPortaal.Manager.MijnPensioen.Contract
{
    public class Questionnaire
    {
        public string Id { get; set; }
        public Answer[] Answers { get; set; }
    }

    public class Answer
    {
        public string Name { get; set; }
        public string Value { get; set; }
    }
}
