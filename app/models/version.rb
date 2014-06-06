# "Wrapper" model for PaperTrail::Version.
class Version < PaperTrail::Version
  self.table_name = :versions
end
