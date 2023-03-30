import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { PopupDeleteLeagueComponent } from './popup-delete-league.component';

describe('PopupDeleteLeagueComponent', () => {
  let component: PopupDeleteLeagueComponent;
  let fixture: ComponentFixture<PopupDeleteLeagueComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ PopupDeleteLeagueComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PopupDeleteLeagueComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
