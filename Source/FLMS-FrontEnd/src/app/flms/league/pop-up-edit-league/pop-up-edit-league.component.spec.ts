import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { PopUpEditLeagueComponent } from './pop-up-edit-league.component';

describe('PopUpEditLeagueComponent', () => {
  let component: PopUpEditLeagueComponent;
  let fixture: ComponentFixture<PopUpEditLeagueComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ PopUpEditLeagueComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PopUpEditLeagueComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
