﻿using FLMS_BackEnd.Request;
using FLMS_BackEnd.Response;

namespace FLMS_BackEnd.Services
{
    public interface FeeService
    {
        Task<LeagueFeeResponse> GetListLeagueFee(int LeagueId);
        Task<FeeDetailResponse> GetLeagueFeeDetail(int LeagueFeeId);
        Task<FeeDetailResponse> UpdateFeeDetail(FeeDetailRequest feeDetailRequest, int UserID);
    }
}
