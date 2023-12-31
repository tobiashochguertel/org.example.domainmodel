/*
 * generated by Xtext 2.33.0
 */
package org.example.domainmodel.tests

import com.google.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.eclipse.xtext.xbase.testing.CompilationTestHelper
import org.example.domainmodel.domainmodel.Domainmodel
import org.example.domainmodel.domainmodel.DomainmodelPackage
import org.example.domainmodel.validation.DomainmodelValidator
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.^extension.ExtendWith

@ExtendWith(InjectionExtension)
@InjectWith(DomainmodelInjectorProvider)
class DomainmodelParsingTest {

	@Inject extension ParseHelper<Domainmodel>

	@Inject extension ValidationTestHelper
	
	@Inject extension CompilationTestHelper

	@Test
	def testValidModel() {
		"entity MyEntity {
	     parent: MyEntity
	     }".parse.assertNoIssues
	}

	@Test
	def testNameStartsWithCapitalWarning() {
		"entity myEntity {
         parent: myEntity
     }".parse.assertWarning(
			DomainmodelPackage.Literals.ENTITY,
			DomainmodelValidator.INVALID_NAME,
			"Name should start with a capital"
		)
	}

	@Test def test() {
		'''
			datatype String
			
			      package my.company.blog {
			          entity Blog {
			              title: String
			          }
			      }
		'''.assertCompilesTo('''
			package my.company.blog;
			
			        public class Blog {
			            private String title;
			
			         public String getTitle() {
			             return title;
			         }
			
			         public void setTitle(String title) {
			             this.title = title;
			         }
			}
		''')
	}
}
