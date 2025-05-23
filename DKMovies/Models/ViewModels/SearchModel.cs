namespace DKMovies.Models.ViewModels
{
    public class SearchModel
    {
        public string Title { get; set; }
        public string Director { get; set; }
        public int? GenreId { get; set; }
        public int? LanguageId { get; set; }
        public int? CountryId { get; set; }
        public DateTime? ReleaseFrom { get; set; }
        public DateTime? ReleaseTo { get; set; }
        public string Sort { get; set; }
    }
}
