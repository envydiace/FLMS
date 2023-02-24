import { TestBed } from '@angular/core/testing';

import { ClubDetailService } from './club-detail.service';

describe('ClubDetailService', () => {
  let service: ClubDetailService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ClubDetailService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
