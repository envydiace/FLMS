import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { PopUpLeagueCostEditComponent } from './pop-up-league-cost-edit.component';

describe('PopUpLeagueCostEditComponent', () => {
  let component: PopUpLeagueCostEditComponent;
  let fixture: ComponentFixture<PopUpLeagueCostEditComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ PopUpLeagueCostEditComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PopUpLeagueCostEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
