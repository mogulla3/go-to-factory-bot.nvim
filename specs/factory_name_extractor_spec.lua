describe("extract", function()
  local FactoryNameExtractor = require("go-to-factory-bot.factory_name_extractor")

  describe("when FactoryBot method is simply called", function()
    it("returns factory name", function()
      assert.equals(FactoryNameExtractor.extract("create(:user)"), "user")
      assert.equals(FactoryNameExtractor.extract("build(:user)"), "user")
      assert.equals(FactoryNameExtractor.extract("build_stubbed(:user)"), "user")
      assert.equals(FactoryNameExtractor.extract("attributes_for(:user)"), "user")
    end)
  end)

  describe("when FactoryBot method is called with traits", function()
    it("returns factory name", function()
      assert.equals(FactoryNameExtractor.extract("create(:user, :admin)"), "user")
      assert.equals(FactoryNameExtractor.extract("build(:user, :admin)"), "user")
      assert.equals(FactoryNameExtractor.extract("build_stubbed(:user, :admin)"), "user")
      assert.equals(FactoryNameExtractor.extract("attributes_for(:user, :admin)"), "user")
    end)
  end)

  describe("when FactoryBot method is called with attributes", function()
    it("returns factory name", function()
      assert.equals(FactoryNameExtractor.extract("create(:user, name: 'Bob')"), "user")
      assert.equals(FactoryNameExtractor.extract("build(:user, name: 'Bob')"), "user")
      assert.equals(FactoryNameExtractor.extract("build_stubbed(:user, name: 'Bob')"), "user")
      assert.equals(FactoryNameExtractor.extract("attributes_for(:user, name: 'Bob')"), "user")
    end)
  end)

  describe("when FactoryBot method is called with traits and attributes", function()
    it("returns factory name", function()
      assert.equals(FactoryNameExtractor.extract("create(:user, :admin, name: 'Bob')"), "user")
      assert.equals(FactoryNameExtractor.extract("build(:user, :admin, name: 'Bob')"), "user")
      assert.equals(FactoryNameExtractor.extract("build_stubbed(:user, :admin, name: 'Bob')"), "user")
      assert.equals(FactoryNameExtractor.extract("attributes_for(:user, :admin, name: 'Bob')"), "user")
    end)
  end)

  describe("when other strings are present before the FactoryBot method call", function()
    it("returns factory name", function()
      assert.equals(FactoryNameExtractor.extract("let(:current_user) { create(:user) }"), "user")
      assert.equals(FactoryNameExtractor.extract("let(:current_user) { build(:user) }"), "user")
      assert.equals(FactoryNameExtractor.extract("let(:current_user) { build_stubbed(:user) }"), "user")
      assert.equals(FactoryNameExtractor.extract("let(:current_user) { attributes_for(:user) }"), "user")
    end)
  end)
end)
