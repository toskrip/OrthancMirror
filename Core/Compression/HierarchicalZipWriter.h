/**
 * Orthanc - A Lightweight, RESTful DICOM Store
 * Copyright (C) 2012 Medical Physics Department, CHU of Liege,
 * Belgium
 *
 * This program is free software: you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * In addition, as a special exception, the copyright holders of this
 * program give permission to link the code of its release with the
 * OpenSSL project's "OpenSSL" library (or with modified versions of it
 * that use the same license as the "OpenSSL" library), and distribute
 * the linked executables. You must obey the GNU General Public License
 * in all respects for all of the code used other than "OpenSSL". If you
 * modify file(s) with this exception, you may extend this exception to
 * your version of the file(s), but you are not obligated to do so. If
 * you do not wish to do so, delete this exception statement from your
 * version. If you delete this exception statement from all source files
 * in the program, then also delete it here.
 * 
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 **/


#pragma once

#include "ZipWriter.h"

#include <map>
#include <list>
#include <boost/lexical_cast.hpp>

namespace Orthanc
{
  class HierarchicalZipWriter
  {
    FRIEND_TEST(HierarchicalZipWriter, Index);
    FRIEND_TEST(HierarchicalZipWriter, Filenames);

  private:
    class Index
    {
    private:
      struct Directory
      {
        typedef std::map<std::string, unsigned int>  Content;

        std::string name_;
        Content  content_;
      };

      typedef std::list<Directory*> Stack;
  
      Stack stack_;

      std::string GetCurrentDirectoryPath() const;

      std::string EnsureUniqueFilename(const char* filename);

    public:
      Index();

      ~Index();

      bool IsRoot() const
      {
        return stack_.size() == 1;
      }

      std::string CreateFile(const char* name);

      void CreateDirectory(const char* name);

      void CloseDirectory();

      static std::string KeepAlphanumeric(const std::string& source);
    };

    Index indexer_;
    ZipWriter writer_;

  public:
    HierarchicalZipWriter(const char* path);

    ~HierarchicalZipWriter();

    void SetCompressionLevel(uint8_t level)
    {
      writer_.SetCompressionLevel(level);
    }

    uint8_t GetCompressionLevel() const
    {
      return writer_.GetCompressionLevel();
    }

    void CreateFile(const char* name);

    void CreateDirectory(const char* name);

    void CloseDirectory();

    void Write(const char* data, size_t length)
    {
      writer_.Write(data, length);
    }

    void Write(const std::string& data)
    {
      writer_.Write(data);
    }
  };
}
