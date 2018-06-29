using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Description;
using SVSApp.Models;

namespace SVSApp.Controllers
{
    public class TreatmentsAPIController : ApiController
    {
        private kychallengeEntities db = new kychallengeEntities();

        // GET: api/TreatmentsAPI
        public IQueryable<Treatment> GetTreatments()
        {
            return db.Treatments;
        }

        // GET: api/TreatmentsAPI/5
        [ResponseType(typeof(Treatment))]
        public IHttpActionResult GetTreatment(int id)
        {
            Treatment treatment = db.Treatments.Find(id);
            if (treatment == null)
            {
                return NotFound();
            }

            return Ok(treatment);
        }

        // PUT: api/TreatmentsAPI/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutTreatment(int id, Treatment treatment)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != treatment.ProcedureID)
            {
                return BadRequest();
            }

            db.Entry(treatment).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!TreatmentExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST: api/TreatmentsAPI
        [ResponseType(typeof(Treatment))]
        public IHttpActionResult PostTreatment(Treatment treatment)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Treatments.Add(treatment);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                if (TreatmentExists(treatment.ProcedureID))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = treatment.ProcedureID }, treatment);
        }

        // DELETE: api/TreatmentsAPI/5
        [ResponseType(typeof(Treatment))]
        public IHttpActionResult DeleteTreatment(int id)
        {
            Treatment treatment = db.Treatments.Find(id);
            if (treatment == null)
            {
                return NotFound();
            }

            db.Treatments.Remove(treatment);
            db.SaveChanges();

            return Ok(treatment);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool TreatmentExists(int id)
        {
            return db.Treatments.Count(e => e.ProcedureID == id) > 0;
        }
    }
}