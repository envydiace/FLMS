import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ClubIncomingMatchComponent } from './club-incoming-match.component';

describe('ClubIncomingMatchComponent', () => {
  let component: ClubIncomingMatchComponent;
  let fixture: ComponentFixture<ClubIncomingMatchComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ClubIncomingMatchComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ClubIncomingMatchComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
