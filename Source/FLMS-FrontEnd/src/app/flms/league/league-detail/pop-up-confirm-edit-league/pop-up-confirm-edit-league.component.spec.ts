import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { PopUpConfirmEditLeagueComponent } from './pop-up-confirm-edit-league.component';

describe('PopUpConfirmEditLeagueComponent', () => {
  let component: PopUpConfirmEditLeagueComponent;
  let fixture: ComponentFixture<PopUpConfirmEditLeagueComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ PopUpConfirmEditLeagueComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PopUpConfirmEditLeagueComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
