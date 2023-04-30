import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { PopUpChooseLosingTeamComponent } from './pop-up-choose-losing-team.component';

describe('PopUpChooseLosingTeamComponent', () => {
  let component: PopUpChooseLosingTeamComponent;
  let fixture: ComponentFixture<PopUpChooseLosingTeamComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ PopUpChooseLosingTeamComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PopUpChooseLosingTeamComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
