namespace FLMS_BackEnd.Response
{
    public class BasePagingResponse : BaseResponse
    {
        public int Total { get; set; }
        public int PageIndex { get; set; }
        public int PageSize { get; set; }
        public int TotalPages
        {
            get
            {
                return PageSize != 0 ? (Total / PageSize) + (Total % PageSize > 0 ? 1 : 0) : 0;
            }
        }
    }
}
