import { TestBed, inject } from '@angular/core/testing';

import { CommitsService } from './commits.service';

describe('CommitsService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [CommitsService]
    });
  });

  it('should be created', inject([CommitsService], (service: CommitsService) => {
    expect(service).toBeTruthy();
  }));
});
