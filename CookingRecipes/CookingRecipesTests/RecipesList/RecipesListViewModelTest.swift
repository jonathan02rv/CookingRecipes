//
//  RecipesListViewModelTest.swift
//  CookingRecipes
//
//  Created by JHONATAHAN RIVERA on 2/10/25.
//

import XCTest
@testable import CookingRecipes
@testable import Domain

final class RecipesListViewModelTest: XCTestCase {

    var sut: RecipesListViewModel!
    var viewSpy: RecipesListViewSpy!
    var useCaseSpy: RecipesListUseCaseSpy!

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        setupRecipesListUseCase()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        viewSpy = nil
        useCaseSpy = nil
    }

    // MARK: Test setup

    func setupRecipesListUseCase() {
        viewSpy = RecipesListViewSpy()
        useCaseSpy = RecipesListUseCaseSpy()
        sut = RecipesListViewModel(useCase: useCaseSpy)
    }

    // MARK: - Tests

    func test_callFetchRecipes() {
        // Given
        sut = RecipesListViewModel(useCase: useCaseSpy)

        // When
        sut.fetchRecipes()

        // Then
        XCTAssertTrue(useCaseSpy.fetchRecipesCalled)
    }

}
